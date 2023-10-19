#2023-08-25
#동적 계획법(01타일)

n = int(input())
arr = [0, 1, 2]

for i in range(3, n+1):
    arr.append((arr[i-1] + arr[i-2]) % 15746)

print(arr[n])