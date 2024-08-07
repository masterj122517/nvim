local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

-- 定义 Makefile 的片段
ls.add_snippets("make", {
  s("makefile_c", {
    t({ "# Makefile generated by luasnip", "" }),
    t({ "CC = " }),
    i(1, "gcc"),
    t({ "", "CFLAGS = -Wall -Werror" }),
    t({ "", "TARGET = " }),
    i(2, "my_program"),
    t({ "", "SRCS = " }),
    i(3, "main.c"),
    t({ "", "OBJS = $(SRCS:.c=.o)", "" }),
    t({ "all: $(TARGET)", "" }),
    t({ "\t$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)", "" }), -- 确保使用 Tab
    t({ "", "$(TARGET): $(OBJS)", "" }),
    t({ "\t$(CC) $(CFLAGS) -o $@ $^", "" }), -- 确保使用 Tab
    t({ "", "%.o: %.c", "" }),
    t({ "\t$(CC) $(CFLAGS) -c $< -o $@", "" }), -- 确保使用 Tab
    t({ "", "clean:", "" }),
    t({ "\trm -f $(OBJS) $(TARGET)", "" }), -- 确保使用 Tab
  }),
})

ls.add_snippets("make", {
  s("makefile_cpp", {
    t({ "# Makefile generated by luasnip", "" }),
    t({ "CC = " }),
    i(1, "g++"),
    t({ "", "CFLAGS = -Wall -Werror" }),
    t({ "", "TARGET = " }),
    i(2, "my_program"),
    t({ "", "SRCS = " }),
    i(3, "main.cpp"),
    t({ "", "OBJS = $(SRCS:.cpp=.o)", "" }),
    t({ "all: $(TARGET)", "" }),
    t({ "\t$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)", "" }), -- 确保使用 Tab
    t({ "", "$(TARGET): $(OBJS)", "" }),
    t({ "\t$(CC) $(CFLAGS) -o $@ $^", "" }), -- 确保使用 Tab
    t({ "", "%.o: %.cpp", "" }),
    t({ "\t$(CC) $(CFLAGS) -c $< -o $@", "" }), -- 确保使用 Tab
    t({ "", "clean:", "" }),
    t({ "\trm -f $(OBJS) $(TARGET)", "" }), -- 确保使用 Tab
  }),
})
