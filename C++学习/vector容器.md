# vector 容器

[参考文章](https://blog.csdn.net/weixin_52115456/article/details/126024253?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522167989024216800227414789%2522%252C%2522scm%2522%253A%252220140713.130102334..%2522%257D&request_id=167989024216800227414789&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~top_positive~default-3-126024253-null-null.142^v76^control_1,201^v4^add_ask,239^v2^insert_chatgpt&utm_term=vector&spm=1018.2226.3001.4187)

## vector的定义

vector<储存的类型> 容器名
如：
储存int型的值 vector<int> v;
储存double型的值 vector<double> v;
储存string型的值 vector<string> v;
储存结构体或者类的值的值 vector<结构体名> v;

当然也可以定义vector数组：
储存int型的值 vector<int> v[n];
储存double型的值 vector<double> v[n];
等等，n为数组的大小

## vector 常用的成员函数

> size()//返回返回容器中元素个数
> begin()//返回头部迭代器
> end()//返回尾部+1迭代器
> rbegin()//返回逆首部迭代器
> rend()//返回逆尾部-1迭代器
> front()//返回首个元素
> back()//返回尾部元素
> push_back()//在末尾添加一个函数
> emplace_back()//和push_back()是一样的作用
> pop_back()//弹出最后一个元素
> empty()//判断是否为空
> insert()//在指定位置插入元素
> erase()//在指定位置删除元素
> clear()//清空容器

