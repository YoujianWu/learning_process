总结：
unordered_map底层基于哈希表实现，内部是无序的。
unordered_map是STL中的一种关联容器。容器中元素类型为std::pair，pair.first对应键-key，pair.second对应值-value。
I. 容器中key具有唯一性，插入和查询速度接近于O(1)（在没有冲突的情况下）。
II. 通过key来检索value，因为会有rehash操作，而不是通过绝对地址（和顺序容器不同）
III. 使用内存管理模型来动态管理所需要的内存空间



[unorder_map](https://blog.csdn.net/u013271656/article/details/113810084)

```
at 					返回索引处元素的引用
begin 				返回指向容器头的迭代器
cbegin				返回指向容器头的迭代器-const
bucket				返回key所对应的桶（bucket）的编号
bucket_count		返回容器中桶（bucket）的个数
bucket_size			返回对应桶（bucket）中的元素个数
cend				返回指向容器尾元素后一个位置的迭代器 - const
clear 				清空容器
count				返回key对应元素的个数，因为unordered_map不允许有重复key，所以返回0或1

emplace 			move
emplace_hint		过迭代器位置进行emplace， 因此可以从参数位置开始搜索，速度更快
empty				判断容器是否为空
end					返回指向容器尾的迭代器
equal_range
erase 				删除元素
find				查找
get_allocator
hash_function	
insert				插入元素
key_eq
load_factor			返回容器当前负载系数
max_bucket_count	返回容器所能包含的桶的最大数量
max_load_factor		容器最大负载系数

max_size			返回容器可以容纳的最大元素数
operator=			重载运算符 =
operator[]			重载运算符 []，通过索引可返回对应元素的引用
rehash				参数n大于当前桶数，rehash，否则容器无变化
reserve 			n大于bucket_count*max_load_factor，rehash，否则容器无变化
size 				返回容器中元素个数
swap				当前容器与参数容器中元素交换
```

```
与 map 的区别
std::map底层是用红黑树实现的
优点：
  I. 内部元素有序，其元素的有序性在很多应用中都会简化很多的操作。
  II. 红黑树结构使得 map 中的插入、删除、查找都可在O(logn)下完成。
  
缺点：
  I. 占用的空间大，map内部实现了红黑树，每一个节点都需要额外保存父节点、孩子节点和红/黑性质，使得每一个节点都占用大量的空间。

std::unordered_map底层是哈希表实现
优点：
  I. 查找速度非常的快，复杂度接近O(1)，插入和删除操作复杂度也接近O(1)，最差情况为O(n)。
  
缺点：
  I. 哈希表结构使得其内部元素无序。
  II. 内存方面，红黑树 VS 哈希表：unordered_map占用的内存要高一些。

无论是查找效率还是插入、删除效率unordered_map都优于map。因此通常情况下使用unordered_map会更加高效一些，当对于那些有顺序要求的问题，用map会更高效一些。
```



###std::pair

[参考文章](https://blog.csdn.net/learning_tortosie/article/details/101694321?spm=1001.2101.3001.6650.2&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-2-101694321-blog-112858358.235%5Ev27%5Epc_relevant_t0_download&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-2-101694321-blog-112858358.235%5Ev27%5Epc_relevant_t0_download&utm_relevant_index=4)

## 介绍

> pair类能将2个数据组合成一个数据，stl中的map就是将key和value放在一起来保存。
>
> 另外，当一个函数需要返回2个数据的时候，可以使用pair。 pair的实现是一个结构体，主要的两个成员变量是first和second。因为是使用struct不是class，所以可以直接使用pair的成员变量。

###std::make_pair

[参考文章](https://blog.csdn.net/qq_20853741/article/details/112858358?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522167992483916800180619572%2522%252C%2522scm%2522%253A%252220140713.130102334..%2522%257D&request_id=167992483916800180619572&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~top_positive~default-1-112858358-null-null.142^v76^control_1,201^v4^add_ask,239^v2^insert_chatgpt&utm_term=std%3A%3Apair&spm=1018.2226.3001.4187)

可以调用 std::pair 和 ==std::make_pair==,可以将任意的两种类型的数据组合在一起并返回
