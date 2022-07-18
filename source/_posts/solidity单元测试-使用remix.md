---
title: solidity单元测试(使用remix)
date: 2020-04-22 17:44:11
tags:
- blockchain
- ethereum
- solidity
categories:
- blockchain
- ethereum
- solidity
---

在remix中对solidity进行单元测试。

<!--more-->

- [一、激活测试插件](#%e4%b8%80%e6%bf%80%e6%b4%bb%e6%b5%8b%e8%af%95%e6%8f%92%e4%bb%b6)
- [二、断言](#%e4%ba%8c%e6%96%ad%e8%a8%80)
  - [Assert.ok(value[, message])](#assertokvalue-message)
  - [Assert.equal(actual, expected[, message])](#assertequalactual-expected-message)
  - [Assert.notEqual(actual, expected[, message])](#assertnotequalactual-expected-message)
  - [Assert.greaterThan(value1, value2[, message])](#assertgreaterthanvalue1-value2-message)
  - [Assert.lesserThan(value1, value2[, message])](#assertlesserthanvalue1-value2-message)
- [三、特殊函数](#%e4%b8%89%e7%89%b9%e6%ae%8a%e5%87%bd%e6%95%b0)
- [四、特殊的交易参数](#%e5%9b%9b%e7%89%b9%e6%ae%8a%e7%9a%84%e4%ba%a4%e6%98%93%e5%8f%82%e6%95%b0)
- [五、样例说明](#%e4%ba%94%e6%a0%b7%e4%be%8b%e8%af%b4%e6%98%8e)
  - [（一）基本测试样例](#%e4%b8%80%e5%9f%ba%e6%9c%ac%e6%b5%8b%e8%af%95%e6%a0%b7%e4%be%8b)
  - [（二）涉及到`msg.sender`的测试样例](#%e4%ba%8c%e6%b6%89%e5%8f%8a%e5%88%b0msgsender%e7%9a%84%e6%b5%8b%e8%af%95%e6%a0%b7%e4%be%8b)
  - [（三）涉及到 `msg.value` 的测试样例](#%e4%b8%89%e6%b6%89%e5%8f%8a%e5%88%b0-msgvalue-%e7%9a%84%e6%b5%8b%e8%af%95%e6%a0%b7%e4%be%8b)
  - [（四）方法执行过程中的错误处理](#%e5%9b%9b%e6%96%b9%e6%b3%95%e6%89%a7%e8%a1%8c%e8%bf%87%e7%a8%8b%e4%b8%ad%e7%9a%84%e9%94%99%e8%af%af%e5%a4%84%e7%90%86)


# 一、激活测试插件

![插件列表](plugin1.png)

![插件页面](plugin2.png)

激活插件之后，点击 `Generate test file`，就可以创建测试文件。

![生成测试文件](generate.png)

# 二、断言

断言很少，官方给出的只有5个。

## Assert.ok(value[, message])

- value: bool
- message: string

## Assert.equal(actual, expected[, message])

- *actual*: uint | int | bool | address | bytes32 | string
- *expected*: uint | int | bool | address | bytes32 | string
- *message*: string

## Assert.notEqual(actual, expected[, message])
- *actual*: uint | int | bool | address | bytes32 | string
- *expected*: uint | int | bool | address | bytes32 | string
- *message*: string

## Assert.greaterThan(value1, value2[, message])
- *value1*: uint | int
- *value2*: uint | int
- *message*: string

## Assert.lesserThan(value1, value2[, message])
- *value1*: uint | int
- *value2*: uint | int
- *message*: string

# 三、特殊函数

- beforeEach() - 在每个测试开始前运行
- beforeAll() - 在所有测试开始前运行
- afterEach() - 在每个测试结束后运行
- afterAll() - 在所有测试结束后运行

# 四、特殊的交易参数

对于涉及到 `msg.sender` 和 `msg.value` 的交易，remix采取特殊的方法来提供这两个参数。

```javascript
/// #sender: account-0
/// #value: 10
function checkSenderIs0AndValueis10 () public payable {
    Assert.equal(msg.sender, TestsAccounts.getAccount(0), "wrong sender in checkSenderIs0AndValueis10");
    Assert.equal(msg.value, 10, "wrong value in checkSenderIs0AndValueis10");
}
```

- 格式：在函数前加上 `/// #sender: account-0` 或者 `/// #value: 10`
- 目前只提供 `#sender` 和 `#value` 两种参数
- 发送者地址的格式是固定的，就是 `account-x` 这个样子的，`x` 的取值只有三个 `[0-2]` (v0.10.0之后可以在`[0-9]`取值，提供10个地址)
- 使用 `TestsAccounts.getAccount(idx)`  来获取测试地址，首地址是合约创建者的地址
- 如果说用到 `#sender` 这个参数，那么必须在合约文件中导入 `import remix_accounts.sol`
- 参数 `#value` 的单位是 `wei`

# 五、样例说明

## （一）基本测试样例

```javascript
/// @notice - 源程序
/// @filename - Simple_storage.sol

pragma solidity >=0.4.22 <0.7.0;

contract SimpleStorage {
    uint public storedData;

    constructor() public {
        storedData = 100;
    }

    function set(uint x) public {
        storedData = x;
    }

    function get() public view returns (uint retVal) {
        return storedData;
    }
}
```

```javascript
/// @notice - 测试程序
/// @filename - Simple_storage_test.sol

pragma solidity >=0.4.22 <0.7.0;
import "remix_tests.sol";  // 自动导入
import "./Simple_storage.sol";  // 待测试的合约

contract MyTest {
    SimpleStorage foo;

    function beforeEach() public {
        foo = new SimpleStorage();
    }

    function initialValueShouldBe100() public returns (bool) {
        return Assert.equal(foo.get(), 100, "initial value is not correct");
    }

    function valueIsSet200() public returns (bool) {
        foo.set(200);
        return Assert.equal(foo.get(), 200, "value is not 200");
    }
}
```

## （二）涉及到`msg.sender`的测试样例

```javascript
/// @notice - 源程序
/// @filename - Sender.sol

pragma solidity >=0.4.22 <0.7.0;
contract Sender {
    address private owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    // 先判断发送者是否和当前owner一致，只有一致时才可以修改
    function updateOwner(address newOwner) public {
        require(msg.sender == owner, "only current owner can update owner");
        owner = newOwner;
    }
    
    function getOwner() public view returns (address) {
        return owner;
    }
}
```

```javascript
/// @notice - 测试程序
/// @filename - Sender_test.sol

pragma solidity >=0.4.22 <0.7.0;
import "remix_tests.sol"; 
import "remix_accounts.sol";  // 因为使用到了 #sender , 所以必须导入该package
import "./Sender.sol";

// 注意，这里是继承合约
contract SenderTest is Sender {
    address acc0;
    address acc1;
    address acc2;
    
    /// 这里的TestsAccounts用来获取测试用户，acc0（首地址） 就是合约的创建者地址
    function beforeAll() public {
        acc0 = TestsAccounts.getAccount(0); 
        acc1 = TestsAccounts.getAccount(1);
        acc2 = TestsAccounts.getAccount(2);
    }
    
    function testInitialOwner() public {
        // 合约初始化之后，owner代表着合约发布者的地址，也就是acc0
        Assert.equal(getOwner(), acc0, 'owner should be acc0');
    }
    
    /// 如果不指定 #sender 参数，那么默认 msg.sender 是测试用的首地址
    function updateOwnerOnce() public {
        Assert.ok(msg.sender == acc0, 'caller should be default account i.e. acc0');

        updateOwner(acc1);

        Assert.equal(getOwner(), acc1, 'owner should be updated to acc1');
    }
    
    /// 通过 #sender: account-1 来指定 msg.sender，即为测试用的编号为 1 的地址
    /// #sender: account-1 
    function updateOwnerOnceAgain() public {
        Assert.ok(msg.sender == acc1, 'caller should be custom account i.e. acc1');
        updateOwner(acc2);
        Assert.equal(getOwner(), acc2, 'owner should be updated to acc2');
    }
}
```

## （三）涉及到 `msg.value` 的测试样例

```javascript
/// @notice - 源程序
/// @filename - Value.sol

pragma solidity >=0.4.22 <0.7.0;
contract Value {
    uint256 public tokenBalance;
    
    constructor() public {
        tokenBalance = 0;
    }
    
    function addValue() payable public {
        tokenBalance = tokenBalance + (msg.value/10);
    } 
    
    function getTokenBalance() view public returns (uint256) {
        return tokenBalance;
    }
}
```

```javascript
pragma solidity >=0.4.22 <0.7.0;
import "remix_tests.sol"; 
import "./Value.sol";

contract ValueTest{
    Value v;
    
    function beforeAll() public {
        v = new Value();
    }
    
    function testInitialBalance() public {
        Assert.equal(v.getTokenBalance(), 0, 'token balance should be 0 initially');
    }
    
    /// 自定义 #value ，也就是 msg.value
    /// #value: 200
    function addValueOnce() public payable {
        Assert.equal(msg.value, 200, 'value should be 200');
        // execute 'addValue'
        v.addValue{gas: 40000, value: 200}(); // 注意这种写法，solidity的版本必须大于 0.6.2，若版本低于0.6.2，就采用 addValueAgain() 中的方法。
        Assert.equal(v.getTokenBalance(), 20, 'token balance should be 20');
    }
     
    /// 对于 solidity 版本小于 0.6.2 的，使用下面这种方式。
    /// #value: 100
    function addValueAgain() public payable {
        Assert.equal(msg.value, 100, 'value should be 100');
        bytes memory methodSign = abi.encodeWithSignature('addValue()');
        (bool success, bytes memory data) = address(v).call.gas(40000).value(100)(methodSign);
        Assert.equal(success, true, 'execution should be successful');
        Assert.equal(v.getTokenBalance(), 30, 'token balance should be 30');
    }
}
```

## （四）方法执行过程中的错误处理

如果 `solidity` 大于 0.6.0， 就是用 `try...catch` 结构，否则使用执行状态返回值的方法，具体见样例。

```javascript
/// @notice - 源程序
/// @filename - AttendanceRegister.sol

pragma solidity >=0.4.22 <0.7.0;
contract AttendanceRegister {
    struct Student{
            string name;
            uint class;
        }

    event Added(string name, uint class, uint time);

    mapping(uint => Student) public register; 

    function add(uint rollNumber, string memory name, uint class) public returns (uint256){
        require(class > 0 && class <= 12, "Invalid class");
        require(register[rollNumber].class == 0, "Roll number not available");
        Student memory s = Student(name, class);
        register[rollNumber] = s;
        emit Added(name, class, now);
        return rollNumber;
    }
    
    function getStudentName(uint rollNumber) public view returns (string memory) {
        return register[rollNumber].name;
    }
}
```

```javascript
/// @notice - 测试程序
/// @filename - AttendanceRegister_test.sol

pragma solidity >=0.4.22 <0.7.0;
import "remix_tests.sol"; 
import "./AttendanceRegister.sol";

contract AttendanceRegisterTest {
   
    AttendanceRegister ar;
    
    function beforeAll () public {
        ar = new AttendanceRegister();
    }
    
    /// solidity 版本大于等于 0.6.0 的时候，使用 try-catch 结构 
    /// try-catch 的具体用法参考: https://solidity.readthedocs.io/en/v0.6.0/control-structures.html#try-catch
    function testAddSuccessUsingTryCatch() public {
        try ar.add(101, 'secondStudent', 11) returns (uint256 r) {
            Assert.equal(r, 101, 'wrong rollNumber');
        } catch Error(string memory /*reason*/) {
            Assert.ok(false, 'failed with reason');
        } catch (bytes memory /*lowLevelData*/) {
            Assert.ok(false, 'failed unexpected');
        }
    }
    

    function testAddFailureUsingTryCatch2() public {
        try ar.add(101, 'secondStudent', 11) returns (uint256 r) {
            Assert.ok(false, 'method execution should fail');
        } catch Error(string memory reason) {
            Assert.equal(reason, 'Roll number not available', 'failed with unexpected reason');
        } catch (bytes memory /*lowLevelData*/) {
            Assert.ok(false, 'failed unexpected');
        }
    }
    
    /// solidity版本小于 0.6.0，使用下面这种方式
    /// 具体参考: https://solidity.readthedocs.io/en/v0.6.0/units-and-global-variables.html#members-of-address-types
    function testAddSuccessUsingCall() public {
        bytes memory methodSign = abi.encodeWithSignature('add(uint256,string,uint256)', 102, 'firstStudent', 10);
        (bool success, bytes memory data) = address(ar).call(methodSign);
        // success 代表了方法是否被正确执行。
        Assert.equal(success, true, 'execution should be successful');
        // data 代表了返回结果，需要进行解码
        uint rollNumber = abi.decode(data, (uint256));
        Assert.equal(rollNumber, 102, 'wrong rollNumber');
    }
}
```

> 参考：https://remix-ide.readthedocs.io/en/latest/unittesting.html