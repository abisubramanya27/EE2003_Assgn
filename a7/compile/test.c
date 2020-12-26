#include "outbyte.c"

int main()
{
        myputs("hello world\n");
        myputs(convert(42, 10));
        int x = readstatus();
        myputs("\nPrinted so far: ");
        myputs(convert(x, 10));
        myputs("\nAnd that's all folks!\n");
        for(;;);
}

