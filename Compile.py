import sys
import os

def main():
    if len(sys.argv)!=2:
        print("参数输入数量错误 请输入2个")
        return
    elif not os.path.isfile(sys.argv[1]) or sys.argv[1][-2:]!='.v':
        print("目标文件非法!")
        return
    else:
        pass
        path,tb = os.path.split(sys.argv[1])
        os.chdir(path)
        os.system('iverilog -s '+tb[:-2]+" -o "+'tar.out *.v')
        os.system('vvp tar.out')
        os.system('gtkwave dumpfile.vcd')

if __name__=='__main__':
    main()