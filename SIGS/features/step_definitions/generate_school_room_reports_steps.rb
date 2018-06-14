And (/^click on link 'Turmas' in 'Relatório'$/) do
  first('.dropdown-menu').click_link('Turmas')
end

And (/^I fill in 'relatorio' with '([^"]*)'$/) do |option|
	choose(option)
end

And (/^I press '([^"]*)' link$/) do |link|
  click_link(link)
end
