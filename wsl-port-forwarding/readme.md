##### system

-   windows 10
-   wsl 2
-   power shall (Administrator required)

##### !! warning !! this script will remove all interface portproxy !!

```
iex "netsh interface portproxy reset"
```

##### how to use

1. pick whatever port you want

```
#[Ports]
$ports=@(3000, 8080, 3500, 3501, 3502);
```

2. execute this script

```
./wsl-port-forwarding.ps1
```

##### Ref

[ref 1](https://github.com/microsoft/WSL/issues/4150#issuecomment-504209723)
[ref 2](https://dev.to/vishnumohanrk/wsl-port-forwarding-2e22)
