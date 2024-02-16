调用类成员数据时，实际上是在调用一个this指针

调用函数时的this指针指向调用该函数的对象

```
void showParam()
{
	std::cout << param << "\n";
  //std::cout << this -> param << "\n";
}
```

所以当声明一个类指针时，一定要先初始化类的数据，否则会导致程序崩溃。