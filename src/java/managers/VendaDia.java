/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package managers;

/**
 *
 * @author Usuario
 */
public class VendaDia {

    public Integer id;
    public String nome; //nome
    public String descricao; //descrição detalhada do produto
    public double valor; //valor unitário
    public Integer estoque; //quantidade de produtos disponíveis
    public Integer id_categoria; //puxa o nome da categoria baseado no id
    public String ativo; //ativo (visível) ou inativo (invisível)
    public String file; // Salva uma Img
    public long quantidade;
    public long total;

}
