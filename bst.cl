(* 
   二叉搜索树 (BST) 实现 - COOL Language
   包含功能: insert, search, printInOrder
*)

(* 节点类：定义树的基本单元 *)
class Node inherits IO {
    val : Int;          -- 节点存储的整数值
    left : Node;        -- 左子节点
    right : Node;       -- 右子节点

    -- 初始化方法
    init(v : Int) : Node {
        {
            val <- v;
            self;
        }
    };

    -- 获取当前节点的值
    get_val() : Int { val };

    -- 递归插入
    insert(new_val : Int) : Object {
        if new_val < val then
            -- 如果新值小于当前值，放左边
            if (isvoid left) then
                left <- (new Node).init(new_val)
            else
                left.insert(new_val)
            fi
        else if val < new_val then
            -- 如果新值大于当前值，放右边
            if (isvoid right) then
                right <- (new Node).init(new_val)
            else
                right.insert(new_val)
            fi
        else
            -- 值相等，BST不允许重复，不做操作 (或者你可以选择更新/计数)
            self 
        fi fi
    };

    -- 递归查找
    search(target : Int) : Bool {
        if target = val then
            true
        else if target < val then
            if (isvoid left) then false else left.search(target) fi
        else
            if (isvoid right) then false else right.search(target) fi
        fi fi
    };

    -- 中序遍历打印 (左 -> 根 -> 右)
    print_in_order() : Object {
        {
            -- 打印左子树
            if (not (isvoid left)) then left.print_in_order() else 0 fi;
            
            -- 打印当前节点
            out_int(val);
            out_string(" ");
            
            -- 打印右子树
            if (not (isvoid right)) then right.print_in_order() else 0 fi;
        }
    };
};

(* 二叉搜索树类：管理 Root 节点 *)
class BST inherits IO {
    root : Node;

    -- 插入接口
    insert(val : Int) : Object {
        if (isvoid root) then
            root <- (new Node).init(val)
        else
            root.insert(val)
        fi
    };

    -- 查找接口
    search(val : Int) : Bool {
        if (isvoid root) then
            false
        else
            root.search(val)
        fi
    };

    -- 打印接口
    print_in_order() : Object {
        {
            out_string("In-order Traversal: ");
            if (isvoid root) then
                out_string("Tree is empty")
            else 
                root.print_in_order()
            fi;
            out_string("\n");
        }
    };
};

(* 主程序：测试用例 *)
class Main inherits IO {
    tree : BST;

    main() : Object {
        {
            out_string("=== BST Challenge Implementation ===\n");
            
            tree <- new BST;

            -- 测试插入
            out_string("Inserting: 50, 30, 20, 40, 70, 60, 80\n");
            tree.insert(50);
            tree.insert(30);
            tree.insert(20);
            tree.insert(40);
            tree.insert(70);
            tree.insert(60);
            tree.insert(80);

            -- 测试打印 (应该输出有序序列)
            tree.print_in_order();

            -- 测试查找
            test_search(40);  -- 应该存在
            test_search(90);  -- 应该不存在
            test_search(20);  -- 应该存在

            out_string("=== Test Finished ===\n");
        }
    };

    test_search(val : Int) : Object {
        {
            out_string("Searching for ");
            out_int(val);
            out_string(": ");
            if tree.search(val) then
                out_string("Found!\n")
            else
                out_string("Not Found.\n")
            fi;
        }
    };
};
