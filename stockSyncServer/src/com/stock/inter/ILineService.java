package com.stock.inter;

import com.stock.dao.Dline;
import com.stock.dao.Hline;
import com.stock.dao.Mline;
import com.stock.dao.Wline;

public interface ILineService {

	public void addMline(Mline mline);

	public void addHline(Hline hline);

	public void addDline(Dline dline);

	public void addWline(Wline wline);

}
