When (/^click on button 'Solicitar Cadastro'$/) do
	click_link ('Solicitar Cadastro')
end

And (/^I fill in user '([^"]*)' with '([^"]*)'$/) do |field, value|
	fill_in("user[#{field}]", :with=> value)
end

And (/^I fill in user type with '([^"]*)'$/) do |value| 
	choose(value)
end

When (/^I press 'Enviar' button$/) do
	click_button('Enviar')
end

Then (/^the initial page should load with notice message 'Solicitação de cadastro efetuado com sucesso!'$/) do
	expect(page).to have_content('Solicitação de cadastro efetuado com sucesso!')
end

Then (/^the initial page should load with notice message 'O Nome deve ter no mínimo 7 caracteres'$/) do
	expect(page).to have_content('O Nome deve ter no mínimo 7 caracteres')
end

Then (/^the initial page should load with notice message 'Insira um Cpf válido'$/) do
	expect(page).to have_content('Insira um CPF válido')
end

Then (/^the initial page should load with notice message 'E-mail não pode ser vazio'$/) do
	expect(page).to have_content('E-mail não pode ser vazio')
end
