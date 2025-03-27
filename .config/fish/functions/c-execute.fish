function c-execute --description="Compile and execute C code"
	gcc main.c -Wall -Wextra -o main.bin -lm -g
	and ./main.bin
end
