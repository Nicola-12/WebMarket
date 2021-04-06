/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function validardados() {
    var erro = 0;
    descricao = document.formCategoria.descricao.value;
    situacao = document.formCategoria.situacao.value;

    if (descricao.length < 5)
    {
        document.formCategoria.descricao.style.backgroundColor = "yellow";
        document.formCategoria.descricao.focus();
        erro++;
    } else {
        document.formCategoria.descricao.style.backgroundColor = "white";
    }
    
     if (situacao.length < 1 || situacao.length > 1)
    {
        document.formCategoria.situacao.style.backgroundColor = "yellow";
        erro++;
    } else {
        document.formCategoria.situacao.style.backgroundColor = "white";
    }
    
    if (erro > 0) {
        window.alert("Preencha os campos corretamente!");
        return false;
    } else {
        return true;
    }
}

