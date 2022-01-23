/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package apoio;

import java.util.ArrayList;

/**
 *
 * @author Nicolas
 */
public interface IDAO<T>
{
    public String save( T objeto );

    public String update( T o );

    public String remove( int id );

    public ArrayList<T> findAll();

    public boolean isUnique( T o );

    public ArrayList<T> getAllByValue( String value );

    public T getById( int id );

    public boolean exists( T o );
}
