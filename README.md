# homework1
about cool language
由于不知道为什么其他文件上传不上来，所以把code也放在readme里了。
how to run:
在VM虚拟机上安装好ubuntu，使用终端，创建一个新文件，建议用nano命令，然后将代码复制粘粘
nano testree.cl
Ctrl+Shift+V粘粘
Ctrl+O
回车
Ctrl+X
coolc testree。cl
spim testree.s
即可

code:
class Main {
    main() : Object {
        {
            let io: IO <- new IO in {
                io.out_string("Testing complete BST...\n");
                
                let tree: BinarySearchTree <- new BinarySearchTree.init() in
                {
                    -- Build test tree
                    io.out_string("Inserting values: 5, 3, 7, 2, 4, 6, 8\n");
                    tree.insert(5);
                    tree.insert(3);
                    tree.insert(7);
                    tree.insert(2);
                    tree.insert(4);
                    tree.insert(6);
                    tree.insert(8);
                    
                    -- In-order traversal
                    tree.printlnOrder();
                    
                    -- Search tests
                    io.out_string("\nSearch tests:\n");
                    io.out_string("Search 4: ");
                    if tree.search(4) then io.out_string("Found\n") else io.out_string("Not found\n") fi;
                    
                    io.out_string("Search 9: ");
                    if tree.search(9) then io.out_string("Found\n") else io.out_string("Not found\n") fi;
                    
                    -- Test duplicate insertion
                    io.out_string("\nTrying to insert duplicate 5:\n");
                    tree.insert(5);
                    
                    -- Insert more values
                    io.out_string("\nInserting 1 and 9:\n");
                    tree.insert(1);
                    tree.insert(9);
                    tree.printlnOrder();
                };
                
                io.out_string("\nAll tests completed successfully!\n");
            };
        }
    };
};

class TreeNode {
    value: Int;
    left: TreeNode;
    right: TreeNode;
    
    init(v: Int) : Object {
        {
            value <- v;
            left <- new TreeNode;
            right <- new TreeNode;
            self;
        }
    };
    
    isNil() : Bool {
        if value = 0 then
            true
        else
            false
        fi
    };
    
    setNil() : Object {
        {
            value <- 0;
            left <- self;
            right <- self;
            self;
        }
    };
};

class BinarySearchTree {
    root: TreeNode;
    
    init() : Object {
        {
            root <- (new TreeNode).setNil();
            self;
        }
    };
    
    insert(value: Int) : Object {
        {
            if root.isNil() then
                root <- new TreeNode.init(value)
            else
                if not search(value) then
                    insertRec(root, value)
                else
                    (new IO).out_string("Value ").out_int(value).out_string(" already exists!\n")
                fi
            fi;
            self;
        }
    };
    
    insertRec(node: TreeNode, value: Int) : TreeNode {
        if node.isNil() then
            new TreeNode.init(value)
        else
            if value < node.value then
                let updatedLeft: TreeNode <- insertRec(node.left, value) in
                {
                    node.left <- updatedLeft;
                    node;
                }
            else
                if value > node.value then
                    let updatedRight: TreeNode <- insertRec(node.right, value) in
                    {
                        node.right <- updatedRight;
                        node;
                    }
                else
                    node
                fi
            fi
        fi
    };
    
    search(value: Int) : Bool {
        searchRec(root, value)
    };
    
    searchRec(node: TreeNode, value: Int) : Bool {
        if node.isNil() then
            false
        else
            if value = node.value then
                true
            else
                if value < node.value then
                    searchRec(node.left, value)
                else
                    searchRec(node.right, value)
                fi
            fi
        fi
    };
    
    printlnOrder() : Object {
        {
            let io: IO <- new IO in {
                io.out_string("In-order traversal: ");
                inOrderRec(root);
                io.out_string("\n");
            };
            self;
        }
    };
    
    inOrderRec(node: TreeNode) : Object {
        if not node.isNil() then
            let io: IO <- new IO in {
                inOrderRec(node.left);
                io.out_int(node.value);
                io.out_string(" ");
                inOrderRec(node.right);
            }
        else
            self
        fi
    };
};
