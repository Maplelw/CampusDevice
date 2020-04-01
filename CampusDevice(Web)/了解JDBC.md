# 了解JDBC

## 目录

- 为什么学习JDBC
- JDBC的DriverManager，Connection，Statement，ResultSet
- Connection，PreparedStatement，ResultSet的作用
- PreparedStatement使用sql语句的三种方法的不同



### 为什么学习JDBC

-----------------------------------------------------------------

​	没有JDBC的时候，如果现在要开发一套系统，使用Java连接MySQL数据库，那么这时候Java程序员需要了解MySQL驱动API，如果使用Java连接Oracle数据库，那么这个时候Java程序员需要了解Oracle数据库驱动API。SUN公司提供一套统一的规范（接口）。然后各个数据库生产商提供这套接口的实现。这套接口规范就是JDBC的规范。

​	总之，JDBC就是连接数据库的工具。



### JDBC的DriverManager，Connection，Statement，ResultSet

------

​	学习JDBC之前肯定要了解数据库的基本操作，所以这里就不啰嗦去讲数据库的基本操作了。

​	JDBC的开发步骤为：

​	1、加载驱动    2、连接数据库    3、操作数据库    4、释放资源

```
/**
 * JDBC的入门程序
 */
public class JDBCDemo1 {

	@Test
	/**
	 * JDBC的入门
	 */
	public void demo1() throws Exception{
		// 1.加载驱动
		Class.forName("com.mysql.jdbc.Driver");
		// 2.获得连接
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/testsql", "root", "123456");
		// 3.基本操作：执行SQL
		// 3.1获得执行SQL语句的对象
		Statement statement = conn.createStatement();
		// 3.2编写SQL语句:
		String sql = "select * from user";
		// 3.3执行SQL:
		ResultSet rs = statement.executeQuery(sql);
		// 3.4遍历结果集:
		while(rs.next()){
			System.out.print(rs.getInt("id")+" ");
			System.out.print(rs.getString("username")+" ");
			System.out.print(rs.getString("password")+" ");
			System.out.print(rs.getString("nickname")+" ");
			System.out.print(rs.getInt("age"));
			System.out.println();
		}
		// 4.释放资源
		rs.close();
		statement.close();
		conn.close();
	}
}
```



### Connection，PreparedStatement，ResultSet的作用

------

 Connection :

就是和数据源对话，记得要判断有没有连接上 

 PreparedStatement :

简单的说，所有sql语句运行前，必然有个解析过程，就好象java代码的编译一样。如果同样的语句运行多次，当然希望它是一次编译多次运行的。这样可以减少编译的过程。 PreparedStatement就是干这事的。 它返回一个编译后的标识。用这个标识系统就可以直接找到编译过的sql来运行。不必要把每次的sql都编译一遍。
此外有些sql只是部分值不同，其他都一样。那么就把不同的部分变成 参数，sql编译后，每次使用不同的参数来实行。
另外由于预编译了，那么sql注入的破坏方式就无效了。因为传入的参数不会改变sql语句

 ResultSet :

 ResultSet类是一种数据库查询结果存储类，就是当查询数据库的时候，可以将查询的结果放在具体的ResultSet对象中，其实我们把这种存储查询结果的ResultSet对象叫做ResultSet结果集。比如我们用aaa表示一个ResultSet对象。 

那么查询的结果无非就是一些符合查询条件的记录集，ResultSet结果集有一个索引指针，最初这个指针是指向第一条记录的前一个位置，也就是没有指向任何内容，使用aaa.next()方法就会使指针往后移动指向下一个记录，所以一定要先执行一次next()函数才会让指针指向第一条记录。

一条记录可能会有好几个属性的内容，那么我们可以使用getXXX(int index)方法类获得具体属性的值，XXX代表以什么样的数据类型方式来读取内容，当指针指向一条记录的时候，比如这条记录的内容就是：0001   张三   3岁。而且这三个属性的值的类型全是String类型，那么我们可以使用aaa.getString(1)来获得内容0001，使用getString(2)来获得内容张三，值得注意：ResultSet的一条记录的索引位置是从1开始的，而不是从0开始。



### PreparedStatement使用sql语句的三种方法的不同

-----

JDBC中Statement 接口提供了三种执行 SQL 语句的方法：

1、executeQuery
2、executeUpdate 
3、execute

使用哪一个方法由 SQL 语句所产生的内容决定。

###### 1、executeQuery方法

 用于产生单个结果集（ResultSet）的语句 ， 这个方法通常被用来执行 SELECT 语句，但也只能执行查询语句，执行后返回代表查询结果的ResultSet对象。例如： 

```Java
Connection conn = JDBCUtils.getConnection();
String sql = "select * from user where u_wechatId = ?";
PreparedStatement ps = conn.prepareStatement(sql);

 //替换参数，从1开始
 ps.setString(1, wechatID);
 ResultSet rs = ps.executeQuery(sql);

 //当找到用户
  if(rs.next())
  {
      User user = new User(rs.getString(1),rs.getInt(2),rs.getInt(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getInt(8),rs.getString(9),rs.getString(10));
       System.out.println("查找成功！");
       return user;
  }
```

###### 2、executeUpdate 

 用于执行 INSERT、UPDATE 或 DELETE 语句以及 SQL DDL（数据定义语言）语句，例如 CREATE TABLE 和 DROP TABLE。
INSERT、UPDATE 或 DELETE 语句的效果是修改表中零行或多行中的一列或多列。
executeUpdate 的返回值是一个整数（int），指示受影响的行数（即更新计数）。
对于 CREATE TABLE 或 DROP TABLE 等不操作行的语句，executeUpdate 的返回值总为零 

```
 //初始化
 Connection conn = JDBCUtils.getConnection();
 //`u_userNo`表示u_userNo为主键
 String sql = "insert into user(`u_userNo`, pm_no, cr_ruleNo, u_wechatId, u_name, u_email, u_phone, u_credit_score, u_user_type, u_classno) values(?,?,?,?,?,?,?,?,?,?)";
 PreparedStatement ps = conn.prepareStatement(sql);

  //将值传进sql中
  ps.setString(1,user.getU_userNo());
  ps.setInt(2,user.getPm_no());
  ps.setInt(3,user.getCr_ruleNo());
  ps.setString(4,user.getU_wechatId());
  ps.setString(5,user.getU_name());
  ps.setString(6,user.getU_email());
  ps.setString(7,user.getU_phone());
  ps.setInt(8,user.getU_credit_score());
  ps.setString(9,user.getU_user_type());
  ps.setString(10,user.getU_classno());

  //执行sql语句并更新数据库
  System.out.println(ps);
  ps.executeUpdate();
  conn.close();           
```



###### 3、execute

 可用于执行任何SQL语句，返回一个boolean值，表明执行该SQL语句是否返回了ResultSet。
如果执行后第一个结果是ResultSet，则返回true，否则返回false。
但它执行SQL语句时比较麻烦，通常我们没有必要使用execute方法来执行SQL语句，而是使用executeQuery或executeUpdate更适合。
但如果在不清楚SQL语句的类型时则只能使用execute方法来执行该SQL语句了。 