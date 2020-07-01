package dto;


public class UserBean implements java.io.Serializable {
	private String id;
	private String password;
	private String email;
	private String name;
	
	// default constructor
	public UserBean() {
		this(null,null,null,null);
	}

	// constructor
	public UserBean(String id, String password, String email, String name) {
		super();
		this.id = id;
		this.password = password;
		this.email = email;
		this.name = name;
	}

	// getter & setter

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "UserBean [id=" + id + ", password=" + password + ", email=" + email + ", name=" + name + "]";
	}

	
	
	
	
	

}
