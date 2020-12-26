#include <stdio.h>
int fib(int n)
{
	if (n<=2) return 1;
	else return fib(n-1) + fib(n-2);
}


int fib2(int n)
{
	return 25;
}

int main()
{
	return fib(3) + fib2(5);
}
