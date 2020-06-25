package com.shihao.Client;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement

public class PassWard {
	private String oldpassward;
	private String newpassward;
	
	public String getOldpassward() {
		return oldpassward;
	}
	public void setOldpassward(String oldpassward) {
		this.oldpassward = oldpassward;
	}
	public String getNewpassward() {
		return newpassward;
	}
	public void setNewpassward(String newpassward) {
		this.newpassward = newpassward;
	}
	
	
}
