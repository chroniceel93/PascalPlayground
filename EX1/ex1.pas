program EX1;

// These are constants and can't be modified, right?
const
    N: array[0..4] of longInt = (45, 7, 68, 2, 34);

// all variables for a function (all vars in a scope?) must be declaired here
var
    sum: longInt = 0;
    avg: real = 0.0;
    i: shortInt;
    readIn, readOut: text;
    txt: string;
    cache: array[0..100] of longInt;

{(VAR fibCount) would pass by reference. Default is pass by value}
{I think I can assume the speed tradeoff is the same as in C/C++}
    procedure fibbonacci (fibCount : shortInt);
    var 
        FibA, FibB, FibC : longInt; {F(n), F(n-1), F(n-2)}
        i : shortInt;
    begin
        // F(0) = 1, F(1) = 1
        FibB := 1;
        FibC := 1;
        i := 0;
        write('1 1');
        // repeat-until encapsulates
        repeat
            // F(n) = F(n-1) + F(n-2)
            // here, FibB = F(n-1) and FibC = F(n-2)
            FibA := FibB + FibC;
            FibC := FibB;
            FibB := FibA;
            // i keeps track of how many fibs we've found- Stops at lineCount!
            i := i + 1;
            write(' ', FibA);
        until (i >= fibCount);
        writeln();
    end;

{Recursive fibonacci sequence}
    function fibbRecursion (fibCount : shortInt) : longInt;
    begin
        if (fibCount = 0) or (fibCount = 1) then
            fibbRecursion := 1
        else
            fibbRecursion := fibbRecursion(fibCount-1)
             + fibbRecursion(fibCount-2);
    end;

    function fibbRecursionCache (
        fibCount : shortInt;
        var fibCache : array of LongInt) : longInt;
    var
        fibTemp : longInt;
    begin
        if (fibCache[fibCount] <> 0) then
            fibbRecursionCache := fibCache[fibCount]
        else if (fibCount = 0) or (fibCount = 1) then
            fibbRecursionCache := 1
        else 
        begin
            fibTemp := fibbRecursionCache((fibCount-1), fibCache) 
                 + fibbRecursionCache((fibCount-2), fibCache);
            fibCache[fibCount] := fibTemp;
            fibbRecursionCache := fibTemp;
        end
    end;

    procedure powersOfTwo;
    const
        lineCount : shortInt = 5; {The number of items we print in a line}
    var
        a, b : longInt; {a = powers, b = counter}
    
    begin
        // A inits to 1- A special case
        a := 1;
        b := 0;
        repeat
        // The special case where a = 1- if true, then multiplying by 2 will
        // equal 1, and we enter an infinite loop- So, we must manually set it
        // to 2- And output a to start things off. Since we're outputting, b
        // must be incremented as well
            if a = 1 then
            begin 
                write('    1, ');
                a := 2;
                b := b + 1;
            end;
            // we're listing powers of two, so simply keep multiplying a by 2
            a := a * 2;
            // and we're keeping track of how far in a given line we are with b
            // we want to print exactly 5 numbers per line
            b := b + 1;
            if b >= lineCount then
            begin
                b := 0;
                writeln(a:5);
            end
            else
                write(a:5, ', ');
        until (a > 20000);
    end;

begin
    // Looks like this languages uses begin and end instead of curly brackets...
    for i := 0 to 4 do
    begin
    // a:b formats things st a is b chars long- Right justified
        writeln('Number', (i + 1):3, ' = ', n[i]);
        sum := sum + n[i];
    end;
    avg := sum / 5;
    writeln('Sum = ', sum);
    writeln('Average = ', avg:10);
    writeln('Average = ', avg:10:1);

    // assign-style file access
    assign(readIn, 'hello.txt');
    // reset() is used to open files as read-only
    reset(readIn);
    // while-do does not encapsulate, must use begin-end
    // OR- do does not encapsulate!
    while not eof(readIn) do
    begin
        readln(readIn, txt);
        writeln(txt);
    end;
    close(readIn);

    assign(readOut, 'out.txt');
    // rewrite() is used top open files as write-only-
    // It overwrites the original file
    // for more see https://wiki.freepascal.org/File_Handling_In_Pascal
    rewrite(readOut);
    for i := 0 to 4 do
        writeln(readOut, 'Number', (i+1):2, ' =', n[i]:5);
    for i := 0 to 14 do
        write(readOut, '=');
    writeln(readOut);
    writeln(readOut, 'Sum =', sum:10);
    // We cheating a little here- Good way to align by decimal in pascal?
    writeln(readOut, 'Average =', avg:9:2);
    close(readOut);

    // Generate FIB
    // f(n) = f(n-1) + f(n-2)
    fibbonacci(10);

    // Caching fibs- Example of dynamic programming!
    FillChar(cache, SizeOf(cache), 0);
    writeln(fibbRecursionCache(100, cache));

    // No optimization
    writeln(fibbRecursion(100));


    // List all powers of two less than 20,000
    powersOfTwo;
end.

(* Not necessarily the best way to do this, but I was experimenting with things!
Best way to remember how to make and access an array, after all, is to make and
access an array! And that's before you bring in for loops, and all that. *)