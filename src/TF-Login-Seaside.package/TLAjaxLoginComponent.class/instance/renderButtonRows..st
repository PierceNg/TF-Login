as yet unclassified
renderButtonRows: html

	html tableRow: [
		html tableData.
			html tableData: [
				self renderLoginButton: html.
				self renderRegisterButton: html.
				self renderCancelButton: html ]].
	self allowAutomaticLogin ifTrue: [
		html tableRow: [
			html tableData.
				html tableData: [
					self renderAutomaticLoginCheckbox: html ]]]
