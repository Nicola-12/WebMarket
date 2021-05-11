/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function setCategoria(categoria) {

    url = new URL(location.href);
    url.searchParams.get("param");
    url.searchParams.set("nome", categoria);

    location.href = url.toString()
}

