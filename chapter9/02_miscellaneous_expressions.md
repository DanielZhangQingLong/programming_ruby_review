## Miscellaneous Expressions

> Ruby 还有些不明显的语句表达式.

### Command Expansion 命令扩展

> `` 直接 或者 界定符号 %x{} 会默认执行你所在操作系统的命令. 返回值是那个命令的标准输出. \n 不会被去掉.

```ruby

`date` # => "Mon May 27 12:30:56 CDT 2013\n" 
`ls`.split[34] # => "newfile"
%x{echo "hello there"} # => "hello there\n"

```

> 在 string 中插入一段 ruby 表达式 使用 `#{}` , 同样的, 这里也是:

```ruby
for i in 0..3
  status = `dbmanager status id=#{i}`
end
```

### Redefining Backquotes 重新定义反引号

> 在命令输出表达式中, 我们说过反引号内的字符串默认作为系统的命令执行. 实际上 string 被传递给了一个叫做 Object#` 的方法, 如果你感兴趣可以复写其.

```ruby
alias old_backquote ` 
def `(cmd)
  result = old_backquote(cmd) 
  if $? != 0
    puts "*** Command #{cmd} failed: status = #{$?.exitstatus}" 
  end
  result
end
print `ls -l /etc/passwd`
print `ls -l /etc/wibble`
produces:
-rw-r--r--  1 root  wheel  5086 Jul 20  2011 /etc/passwd
ls: /etc/wibble: No such file or directory
*** Command ls -l /etc/wibble failed: status = 1
```
