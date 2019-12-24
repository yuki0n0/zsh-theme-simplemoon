# root
if Dir.pwd == '/'
    puts '%K{240}%F{231} / %f%k'
    exit 0
end

# variables
pwd = Dir.pwd.split('/')
git_root = `git rev-parse --show-toplevel 2>/dev/null`.chomp.split('/')

# home
home = Dir.home.split('/')
pwd[0...home.count] = '~' if pwd[0...home.count] == home
git_root[0...home.count] = '~' if git_root[0...home.count] == home

# each folder
pwd = pwd.map.with_index do |v, i|

    # home
    next "%F{231}#{v}%f" if i == 0 && v == '~'
    
    # last
    next "%F{231}#{v}%f" if i == pwd.count - 1

    # git directory
    next "%F{250}#{v}%f" if i == git_root.count - 1 && git_root == pwd[0...git_root.count]

    next ''
end

# join
puts '%K{240} ' + pwd.join('%F{231}/%f') + ' %k'