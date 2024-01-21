use std::rc::Rc;

use leptos::web_sys::js_sys::Intl::DateTimeFormat;

type NodeRef = Rc<Node>;

struct Node {
    parent: Option<NodeRef>,
    children: Vec<NodeRef>,
    spouse: Option<NodeRef>,
    name: String,
    birth: Option<DateTimeFormat>,
    death: Option<DateTimeFormat>,
}

impl Node {
    /// Creates a new [`Node`].
    fn new(&self, name: String) -> Self {
        Node {
            parent: None,
            children: vec![],
            spouse: None,
            name,
            birth: None,
            death: None,
        }
    }

    /// Adds a new [`Child`] to current [`Node`]
    fn add_child(&mut self, child: NodeRef) {
        self.children.push(child);
    }

    /// Get the index of a child [`Node`] by the name of the child
    fn get_child_index_by_name(&self, name: String) -> Option<usize> {
        for (i, child) in self.children.iter().enumerate() {
            if child.name == name {
                return Some(i);
            }
        }
        None
    }

    /// Get the index of a child [`Node`] by the [`NodeRef`] itself
    fn get_child_index_by_ref(&self, reference: NodeRef) -> Option<usize> {
        for (i, child) in self.children.iter().enumerate() {
            if Rc::ptr_eq(&reference, child) {
                return Some(i);
            }
        }
        return None;
    }

    // Remove a child by its name
    fn remove_child_by_name(&mut self, name: String) {
        match self.get_child_index_by_name(name) {
            Some(i) => _ = self.children.remove(i),
            None => (),
        }
    }

    // Remove a child by its [`NodeRef`]
    fn remove_child_by_ref(&mut self, child: NodeRef) {
        match self.get_child_index_by_ref(child) {
            Some(i) => _ = self.children.swap_remove(i),
            None => (),
        }
    }

    fn get_full_name(&self) -> String {
        match self.parent.clone() {
            Some(parent) => {
                let self_name = self.name.to_string();
                let parent_full_name = parent.get_full_name();
                return format!("{self_name} {parent_full_name}").to_string();
            }
            None => return self.name.clone(),
        }
    }

    // fn set_parent(&mut self, parent: &mut Node) {
    //     unsafe {
    //         let self_rc = Rc::from_raw(self);
    //         parent.add_child(self_rc);
    //     }
    //     self.parent = Some(Rc::new(parent));
    // }
}
