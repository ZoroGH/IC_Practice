### 编译命令

**`iverilog`**

```sh
Usage: iverilog [-EiSuvV] [-B base] [-c cmdfile|-f cmdfile]
                [-g1995|-g2001|-g2005|-g2005-sv|-g2009|-g2012] [-g<feature>]   
                [-D macro[=defn]] [-I includedir] [-L moduledir]
                [-M [mode=]depfile] [-m module]
                [-N file] [-o filename] [-p flag=value]
                [-s topmodule] [-t target] [-T min|typ|max]
                [-W class] [-y dir] [-Y suf] [-l file] source_file(s)   
```

常用命令(注: -s topmodule 中参数不带扩展名)

```
iverilog -s tb *.v
```

**`vvp`**

```sh
vvp a.out
```

波形查看 **`gtkwave`**

```gtkwave
gtkwave mydumpfile.vcd
```





