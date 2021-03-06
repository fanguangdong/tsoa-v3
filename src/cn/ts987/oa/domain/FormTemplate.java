package cn.ts987.oa.domain;

import java.io.Serializable;

public class FormTemplate implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private Long id;
	
	private String name;
	
	private String description;
	
	private String docType;
	
	private String pdKey;  //processDefinitionKey
	
	private String path;

	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPdKey() {
		return pdKey;
	}

	public void setPdKey(String pdKey) {
		this.pdKey = pdKey;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDocType() {
		return docType;
	}

	public void setDocType(String docType) {
		this.docType = docType;
	}
	
}
