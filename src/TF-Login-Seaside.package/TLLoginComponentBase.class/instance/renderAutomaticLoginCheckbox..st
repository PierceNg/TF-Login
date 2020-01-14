rendering
renderAutomaticLoginCheckbox: html

	html checkbox
		value: (self automaticLogin);
		callback: [ :v | self automaticLogin: v. ];
		with: [
			html span
				class: 'loginformtext';
				id: 'automaticlogintext';
				with: 'Log me in automatically when I return to this website.']