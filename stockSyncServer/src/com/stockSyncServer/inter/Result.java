package com.stockSyncServer.inter;

import java.rmi.Remote;
import java.rmi.RemoteException;


/**
 * <p>
 * <b> Insert description of the classes responsibility/role. NOT what uses it. </b>
 * </p>
 */
public interface Result extends Remote {
    
    public String getResult() throws RemoteException;
    
    public void setResult(String cypherText) throws RemoteException;
    
    public boolean isProcessed() throws RemoteException;
    
    public void setProcessed() throws RemoteException;
    
}
