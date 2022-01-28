import sys
import argparse
import requests
from junitparser import JUnitXml, TestCase, TestSuite, Skipped, Error
import os
from os import path
import shutil

def readTests() -> []:
    resp = requests.get('http://127.0.0.1:80/WsTest/')
    if (resp.status_code != requests.codes.ok):
        return []
    #print('found these tests available')
    availableTests = []
    for test in resp.json()['itemList']:
        availableTests.append(test['device'])
        #print('{} {}'.format(test['device'], test['description']))
    return availableTests

def cleanTestDir(directory):
    contents = [os.path.join(directory, i) for i in os.listdir(directory)]
    [os.remove(i) if os.path.isfile(i) or os.path.islink(i) else shutil.rmtree(i) for i in contents]

def runTest(name, output) -> bool:
    resp = requests.get(f'http://127.0.0.1:80/WsTest/{name}')
    if (resp.status_code != requests.codes.ok):
        print('invalid response ' + resp.status_code)
        return False

    xml = JUnitXml.fromstring(resp.text.replace('encoding="utf-8"', ''))
    results = []
    failed = False
    for suite in xml:
        f = JUnitXml()
        s = TestSuite(suite.name)
        for p in suite.properties():
            s.add_property(p.name, p.value)
            if (p.name == 'TotalAssertsFailures'):
                results.append({suite.name, p.value})
                if (int(p.value) > 0):
                    failed = True
        for ts in suite.testsuites():
            sts = TestSuite(ts.name)
            for case in ts:
                sts.add_testcase(case)
            s.add_testsuite(sts)
            s.tests += sts.tests
            s.failures += sts.failures
        for case in suite:
            s.add_testcase(case)
        f.add_testsuite(s)
        if (s.tests > 0):
            f.write(f'{output}\\{suite.name}.xml')
    #print(resp.text)
    return failed

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', '--test', help='test to run', dest='testName', required=True)
    parser.add_argument('-o', '--output', help='directory to store the results', dest='output', required=False, default='TestResults')
    args = parser.parse_args()
    availableTests = readTests()

    if (path.isdir(f'{args.output}') == False):
        os.mkdir(f'{args.output}')

    cleanTestDir(args.output)
    failedTests = []
    if (args.testName == 'all'):
        for t in availableTests:
            print('running test ' + t)
            if (runTest(t, args.output) == True):
                failedTests.append(t)
    elif (args.testName in availableTests):
        if (runTest(args.testName, args.output) == True):
            failedTests.append(args.testName)

    for t in failedTests:
        print(t + ' test failed')
    sys.exit(0 if len(failedTests) == 0 else 1)
    return

if __name__ == '__main__':
    main()