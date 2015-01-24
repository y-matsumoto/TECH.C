#encoding: utf-8

require 'mechanize'

agent = Mechanize.new
page = agent.get('http://google.co.jp/')
form = page.forms.first
form.q = 'apple'
p agent.submit(form)