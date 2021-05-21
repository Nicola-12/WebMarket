/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function validardados() {
    var erro = 0;
    descricao = document.formCateg.descricao.value;

    if (descricao.length < 3)
    {
        document.formCateg.descricao.style.outlineColor = "red";
        document.formCateg.descricao.focus();
        erro++;
    } else {
        document.formCateg.descricao.style.borderColor = "white";
    }

}

function validarLogin() {
    var erro = 0;
    email = document.getElementsByName("email");
    senha = document.getElementsByName("senha");

    if (!email.value.match(/^[_A-Za-z0-9-\+]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})$/)) {
        document.main.formLog.email.style.borderColor = "red";
        document.main.formLog.email.focus();
        erro++;
    } else {
        document.main.formLog.email.style.borderColor = "white";
    }

}

