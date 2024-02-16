//
// Created by kook on 10/22/23.
//

#include <iostream>
#include <boost/algorithm/algorithm.hpp>

int main()
{
  int a ,n;
  std::cout << "请输入一个数，再输入你想要的n次方" << std::endl;
  std::cin >> a;
  std::cin >> n;

  std::cout << "这是第五个例子" << std::endl;
  std::cout << a << "的" << n << "次方是" << boost::algorithm::power(a,n) << std::endl;

  return 0;
}
