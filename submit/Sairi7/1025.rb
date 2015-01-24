#! ruby -Ks
era = "invalid:"

user = "@ASDDDD"
	if /\A@+[A-Z]{3,}+\z/ =~ user
		p user
	else
		p era
	end

tel = "0232-252-222"
	if /\A0\d{2,3}-\d{3,4}-\d{3,4}\z/ =~tel && /[0-9-]{12,13}\z/ =~ tel || /\A0+\d{9,10}+\z/ =~ tel
		p tel
	else
		p era
	end

zip = "555-9599"
	if /[0-9]{7}\z/ =~ zip || /[0-9]{3}-[0-9]{4}\z/ =~ zip
		p zip
	else
	 	p era
	end

mail = "s8dfD43aD@lll.iii."
	if /[a-zA-Z0-9]@[a-zA-Z0-9]+(\.[a-zA-Z0-9])/ =~ mail
		p mail
	else
		p era
	end


