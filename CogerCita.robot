*** Settings ***
Variables  variables/variables.py
Library  SeleniumLibrary
Library    Collections

*** Variables ***
@{MESES}  enero  febrero  marzo  abril  mayo  junio  julio  agosto  septiembre  octubre  noviembre  diciembre
${DIA}  2
${MES}  9
${HORA}  07:30
${POLIDEPORTIVO}  Cruces

*** Test Cases ***
PillarClase
    Login
    Acceder SalaMultitrabajo
    Coger Clase
    Confirmar Compra


*** Keywords ***
Login
    Open Browser  https://deportesweb.madrid.es/DeportesWeb/Login  chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //a[contains(text(),'Acceder')]
    Click Element    //a[contains(text(),'Acceder')]
    
    Wait Until Element Is Visible    id=acceso_pass
    Click Element    id=acceso_pass

    Wait Until Element Is Visible    id=correoelectronico
    Input Text  id=correoelectronico  ${USER}
    Input Password    id=contrasenia    ${PASS}
    Click Element    (//div[@id='user-pass']//button)[1]

Acceder SalaMultitrabajo
    Wait Until Element Is Visible  //*[text()='Sala multitrabajo']  30
    Click Element  //*[text()='Sala multitrabajo']  
    
    Wait Until Element Is Visible    //input[@type='text']
    Input Text  //input[@type='text']  ${POLIDEPORTIVO}

    Wait Until Element Is Visible    //a[contains(.,'${POLIDEPORTIVO}')]
    Click Element    //a[contains(.,'${POLIDEPORTIVO}')]

Coger Clase
    Comment  Cambiar mes
    Wait Until Element Is Visible    (//div[@class='datepicker']//table)[1]//th[@class='picker-switch']
    ${index_month}  Evaluate  ${MES} - 1
    Log to console  mes ${mes}
    Log to console  index ${index_month}
    ${target_month}  Get From List  ${MESES}  ${index_month}

    FOR  ${i}  IN RANGE      12
        TRY
            ${current_month}  Get Text    (//div[@class='datepicker']//table)[1]//th[@class='picker-switch']
            Log to console  ${i} ${current_month} ${MESES}[${index_month}]
            Should Contain    ${current_month}    ${MESES}[${index_month}]
            BREAK
        EXCEPT
            Wait Until Element Is Visible    (//div[@class='datepicker']//th[@class='next'])[1]
            Click Element  (//div[@class='datepicker']//th[@class='next'])[1]
            Sleep  1
            CONTINUE            
        END
    END

    # Dia
    Wait Until Element Is Visible  (//td[text()='${DIA}'][not(contains(@class,'disabled'))])[1]
    Click Element  (//td[text()='${DIA}'][not(contains(@class,'disabled'))])[1]

    # Hora
    Wait Until Element Is Visible    //ul[@class='media-list clearfix']//h4[text()='${HORA}']
    Click Element    //ul[@class='media-list clearfix']//h4[text()='${HORA}']

Confirmar Compra
    Wait Until Element Is Visible  //button[@id='ContentFixedSection_uCarritoConfirmar_btnConfirmCart']
    # Input Text  //input[@id='ContentFixedSection_uCarritoConfirmar_txtNombre']  ${NAME}
    # Input Text  //input[@id='ContentFixedSection_uCarritoConfirmar_txtApellidos']  ${SURNAME}
    # Input Text  //input[@id='ContentFixedSection_uCarritoConfirmar_txtCorreoElectronico']  ${USER}  
    # Input Text  //input[@id='ContentFixedSection_uCarritoConfirmar_txtRepitaCorreoElectronico']  ${USER}  

    Sleep   1
    Click Element  //button[@id='ContentFixedSection_uCarritoConfirmar_btnConfirmCart']

    Sleep  10000
