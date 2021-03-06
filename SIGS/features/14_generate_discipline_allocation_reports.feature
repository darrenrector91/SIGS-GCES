Feature: Generate discipline allocation reports
  To use application resources
  As a system user
  I would like to generate a report by discipline

    Background:
        Given I am logged in as coordinator
        And click on link 'Relatórios'
        And click on link 'Disciplinas' in 'Relatório'

    Scenario: Generate report single discipline
        And click on link 'Icon pdf'
        Then generate a PDF

    Scenario: Generate report single discipline with find
        Then the 'Relatório por Disciplina' page show some disciplines
        And fill 'name' with 'Artes'
        And click on button 'searchButton'
        Then the 'Relatório por Disciplina' page show 'Artes Visuais'
        And click on link 'Icon pdf'
        Then generate a PDF

    Scenario: Generate report single discipline with empty find
        Then the 'Relatório por Disciplina' page show some disciplines
        And fill 'name' with ''
        And click on button 'searchButton'
        Then the 'Relatório por Disciplina' page show some disciplines
        And click on link 'Icon pdf'
        Then generate a PDF

    Scenario: Generate report single discipline with nonexistents
        Then the 'Relatório por Disciplina' page show some disciplines
        And fill 'name' with 'X'
        And click on button 'searchButton'
        Then the 'Relatório por Disciplina' page show 'Não há disciplinas registradas.'
