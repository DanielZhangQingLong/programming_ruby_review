array = %w( fred wilma barney betty great\t gazoo )
# => ["fred", "wilma", "barney", "betty", "great gazoo"]
# 省去了每个字符串都写引号的麻烦

array = %w( Hey!\tIt is now -#{Time.now}- )
# => ["Hey!\\t", "is", "now", "-\#{Time.now}-"]
# => ["Hey!\tIt", "is", "now", "-#{Time.now}-"]

array = %W( Hey!\tIt is now -#{Time.now}- )
# => ["Hey!\t", "is", "now", "-2015-01-05 14:35:25 +0800-"]
# => ["Hey! It", "is", "now", "-2013-05-27 12:31:31 -0500-"]

# > w 和 W 类似于'' 和 "", 前者为所见即所得, 后者则更加聪明, 会如果内容涉及到转义
# > 会进行转义. 需要说明一点, 为了方面观察, irb 自动为\ # 等特殊字符添加了转义 \ , 
