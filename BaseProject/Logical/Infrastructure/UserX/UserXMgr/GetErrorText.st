
ACTION GetErrorText: 
	
	IF UserXMgrUIConnect.MessageBox.ErrorNumber <> 0 OR UserXLoginUIConnect.MessageBox.ErrorNumber <> 0 THEN
		IF UserXMgrUIConnect.MessageBox.ErrorNumber =  28672 OR UserXLoginUIConnect.MessageBox.ErrorNumber =  28672 THEN
			ErrorText := '$$IAT/UserMgmt/Error.28672';
		ELSIF UserXMgrUIConnect.MessageBox.ErrorNumber = 28673  OR UserXLoginUIConnect.MessageBox.ErrorNumber =  28673 THEN
			ErrorText := '$$IAT/UserMgmt/Error.28673';
		ELSIF UserXMgrUIConnect.MessageBox.ErrorNumber = 28674 OR UserXLoginUIConnect.MessageBox.ErrorNumber = 28674 THEN
			ErrorText := '$$IAT/UserMgmt/Error.28674';
		ELSIF UserXMgrUIConnect.MessageBox.ErrorNumber = 28676 OR UserXLoginUIConnect.MessageBox.ErrorNumber = 28676 THEN
			ErrorText := '$$IAT/UserMgmt/Error.28676';	
		ELSIF UserXMgrUIConnect.MessageBox.ErrorNumber = 28677  OR UserXLoginUIConnect.MessageBox.ErrorNumber = 28677 THEN
			ErrorText := '$$IAT/UserMgmt/Error.28677';	
		ELSIF UserXMgrUIConnect.MessageBox.ErrorNumber = 28679 OR UserXLoginUIConnect.MessageBox.ErrorNumber  = 28679 THEN
			ErrorText := '$$IAT/UserMgmt/Error.28679';	
		ELSIF UserXMgrUIConnect.MessageBox.ErrorNumber = 28680 OR UserXLoginUIConnect.MessageBox.ErrorNumber = 28680 THEN
			ErrorText := '$$IAT/UserMgmt/Error.28680';	
		ELSIF UserXMgrUIConnect.MessageBox.ErrorNumber = 28685 OR UserXLoginUIConnect.MessageBox.ErrorNumber = 28685 THEN
			ErrorText := '$$IAT/UserMgmt/Error.28685';
		ELSIF UserXMgrUIConnect.MessageBox.ErrorNumber = 28698  OR UserXLoginUIConnect.MessageBox.ErrorNumber = 28698 THEN
			ErrorText := '$$IAT/UserMgmt/Error.28698';	
		ELSIF UserXMgrUIConnect.MessageBox.ErrorNumber =  28706 OR UserXLoginUIConnect.MessageBox.ErrorNumber = 28706 THEN
			ErrorText := '$$IAT/UserMgmt/Error.28706';
		ELSIF UserXMgrUIConnect.MessageBox.ErrorNumber =  28695  OR UserXLoginUIConnect.MessageBox.ErrorNumber = 28695 THEN
			ErrorText := '$$IAT/UserMgmt/Error.28695';	
		ELSIF UserXMgrUIConnect.MessageBox.ErrorNumber =  28672 OR UserXLoginUIConnect.MessageBox.ErrorNumber = 28672 THEN
			ErrorText := '$$IAT/UserMgmt/Error.28672';	
		ELSIF UserXMgrUIConnect.MessageBox.ErrorNumber =  0  OR UserXLoginUIConnect.MessageBox.ErrorNumber = 0 THEN	
			ErrorText := '$$IAT/UserMgmt/Error.0';	
		END_IF
	END_IF	

END_ACTION
