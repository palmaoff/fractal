NAME = fractol

SRC =   main.c \
		img.c \
		fractol.c \
		key.c \
		zoom.c \
		peaces.c \
		input.c

OBJ = $(addprefix $(OBJDIR), $(SRC:.c=.o))

CC = gcc
FLAGS = -Wall -Wextra -Werror

LIB = ./libft/
LIB_INK = -I ./libft
LIBFT =	libft/libft.a

MLX = ./minilibx_macos/
MLX_LIB	= $(addprefix $(MLX),mlx.a)
MLX_INK	= -I ./minilibx_macos

MLX_LNK = -L minilibx_macos -lmlx -framework OpenGL -framework AppKit

SRCDIR	= ./src/
INKDIR	= ./includes/
OBJDIR	= ./obj/

all: $(NAME) 

$(NAME): obj $(MLX_LIB) $(LIBFT) $(OBJ) ./libft/
		@$(CC) $(FLAGS) $(OBJ) $(MLX_LNK) -o $(NAME) $(LIBFT)
		@echo "\033[32m- fractol compiled\033[0m"

obj:
	@mkdir -p $(OBJDIR)

$(OBJDIR)%.o:$(SRCDIR)%.c
		$(CC) $(FLAGS) $(MLX_INK) -I $(INKDIR) $(LIB_INK) -o $@ -c $< 
		
$(MLX_LIB):
	@make -C $(MLX)
	@echo "\033[32m- libmlx compiled\033[0m"

$(LIBFT):
	@make -C $(LIB)
	@echo "\033[32m- libft compiled\033[0m"

clean:
		@rm -f $(OBJ)
		@make -C $(LIB) clean
		@make -C $(MLX) clean
		@echo "\033[31m- fractol object files removed\033[0m"

fclean: clean
		@rm -f $(NAME)
		@make -C $(MLX) clean
		@echo "\033[31m- libmlx.a removed\033[0m"
		@make -C $(LIB) fclean

re: fclean all

.PHONY : all, re, clean, fclean
