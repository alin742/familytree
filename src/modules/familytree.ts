import { FamilyNode } from "./familynode"

export class FamilyTree {
  root: FamilyNode.FamilyNode;
  public get_root() : FamilyNode.FamilyNode {
    return this.root;
  }
}
