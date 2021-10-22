import sys
import os

def main():
    if len(sys.argv)!=2:
        print("参数输入数量错误 请输入2个")
        return
    elif not os.path.isdir(sys.argv[1]):
        print("路径非法!")
        return
    else:
        for path,dirnames,filenames in os.walk(sys.argv[1]):
            for filename in filenames:
                base,ext = os.path.splitext(filename)
                if ext in['.out','.vcd']:
                    os.remove(os.path.join(path,filename))

if __name__=='__main__':
    main()