export module FamilyNode {
  export class FamilyNode {
    private name: String;
    private parent: FamilyNode | null;
    private children: FamilyNode[];
    private spouse: FamilyNode | null;
    private birth: Date | null;
    private death: Date | null;
    private description: String | null;
    public constructor(
      name: String,
      parent: FamilyNode = null,
      children: FamilyNode[] = [],
      spouse: FamilyNode = null,
      birth: Date = null, death: Date = null,
      description: String = null
    ) {
      this.name = name;
      this.parent = parent;
      this.children = children;
      this.spouse = spouse;
      this.birth = birth;
      this.death = death;
      this.description = description;
    }

    public add_child(child: FamilyNode) {
      this.children.push(child);
      child.parent = this;
    }

    public remove_child(child_ref: FamilyNode) {
      const child_index = this.get_child_index(child_ref);
      if (child_index > 0) {
        this.children.splice(child_index,1);
      }
    }

    public get_child_by_name(name: String) : FamilyNode | null {
      var child_out : FamilyNode | null = null;
      this.children.forEach((child : FamilyNode) => {
        if (child.name === name) {
          child_out = child;
        }
      })
      return child_out;
    }

    public get_child_index(child_ref : FamilyNode) : number {
      var child_index = -1;
      this.children.forEach((child, index) => {
        if (child === child_ref) {
          child_index = index;
        }
      })
      return child_index;
    }

    public get_child_index_by_name(child_name_ref : String) : number {
      var child_index = -1;
      this.children.forEach((child, index) => {
        if (child.name === child_name_ref) {
          child_index = index;
        }
      })
      return child_index;
    }

    public get_children() : FamilyNode[] {
      return this.children;
    }

    public get_parent() : FamilyNode | null {
      return this.parent;
    }

    public get_name() : String {
      return this.name;
    }

    public get_full_name() : String {
      if (this.parent !== null) {
        return this.name + " " + this.parent.get_full_name();
      }
      return this.name;
    }

    public get_spouse() : FamilyNode | null {
      return this.spouse;
    }

    public get_birth() : Date | null {
      return this.birth;
    }

    public get_death() : Date | null {
      return this.death;
    }

    public get_description() : String | null {
      return this.description;
    }

    public set_name(name : String) : void {
      this.name = name;
    }

    public set_parent(parent : FamilyNode) : void {
      this.parent = parent;
    }

    public set_spouse(spouse : FamilyNode) : void {
      this.spouse = spouse;
    }

    public set_birth(birth : Date) : void {
      this.birth = birth;
    }

    public set_death(death : Date) : void {
      this.death = death;
    }

    public set_description(description : String) : void {
      this.description = description;
    }

    public empty_children() : void {
      this.children = [];
    }
  }
}
