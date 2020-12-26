#include "outbyte.c"

int fib(int n)
{
	if (n<=2) return 1;
	else return fib(n-1) + fib(n-2);
}

int main()
{
	if (fib(6)==8) 
		myputs("HelloWorld\n");
	else
		myputs("GoodbyeWorld\n");

	// Infinite loop to avoid repeating the program	
	for(;;);
	// return 42;
}
