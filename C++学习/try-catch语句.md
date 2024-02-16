# try catch 语句

> 在 C++ 中，一个函数能够检测出异常并且将异常返回，这种机制称为抛出异常。当抛出异常后，函数调用者捕获到该异常，并对该异常进行处理，我们称之为异常捕获。
>
> C++ 新增 throw 关键字用于抛出异常，新增 catch 关键字用于捕获异常，新增 try 关键字尝试捕获异常。通常将尝试捕获的语句放在try{ }程序块中，而将异常处理语句置于catch{ }语句块中。

> 拋出异常而不加处理会导致函数 A 立即中止，在这种情况下，函数 B 可以选择捕获 A 拋出的异常进行处理，也可以选择置之不理。如果置之不理，这个异常就会被拋给 B 的调用者，以此类推。
>
> 如果一层层的函数都不处理异常，异常最终会被拋给最外层的 main 函数。main 函数应该处理异常。如果main函数也不处理异常，那么程序就会立即异常地中止。

```
try
{
    //可能抛出异常的语句
}
catch (异常类型1)
{
    //异常类型1的处理程序
}
catch (异常类型2)
{
    //异常类型2的处理程序
}
// ……
catch (异常类型n)
{
    //异常类型n的处理程序
}

```

[参考文章1](https://blog.csdn.net/u014489699/article/details/100555653?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-100555653-blog-121904877.235%5Ev27%5Epc_relevant_t0_download&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-100555653-blog-121904877.235%5Ev27%5Epc_relevant_t0_download&utm_relevant_index=1)

[参考文章2](https://blog.csdn.net/qq_52916060/article/details/121904877?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_utm_term~default-4-121904877-blog-101476861.235^v27^pc_relevant_t0_download&spm=1001.2101.3001.4242.3&utm_relevant_index=7)