/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function validardados() {
    var erro = 0;
    descricao = document.formCateg.descricao.value;

    if (descricao.length < 5)
    {
        document.formCateg.descricao.style.borderColor = "red";
        document.formCateg.descricao.focus();
        erro++;
    } else {
        document.formCateg.descricao.style.borderColor = "white";
    }
    
    if (erro > 0) {
        window.alert("Preencha os campos corretamente!");
        return false;
    } else {
        return true;
    }
}

