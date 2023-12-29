import { FamilyNode } from "./familynode";

test("Get Full Name", () => {
  const root = new FamilyNode.FamilyNode("root");
  const child1 = new FamilyNode.FamilyNode("child 1");
  const child2 = new FamilyNode.FamilyNode("child 2");
  child1.add_child(child2);
  root.add_child(child1);
  expect(child2.get_full_name()).toBe("child 2 child 1 root");
});

test("Add Child", () => {
  const root = new FamilyNode.FamilyNode("root");
  const child1 = new FamilyNode.FamilyNode("child 1");
  const child2 = new FamilyNode.FamilyNode("child 2");
  root.add_child(child1);
  root.add_child(child2);
  expect(root.children).toEqual([child1, child2]);
});

test("Get Child by Name", () => {
  const root = new FamilyNode.FamilyNode("root");
  const child1 = new FamilyNode.FamilyNode("child 1");
  const child2 = new FamilyNode.FamilyNode("child 2");
  root.add_child(child1);
  root.add_child(child2);
  expect(root.get_child_by_name("child 2")).toEqual(child2);
});

test("Remove Child", () => {
  const root = new FamilyNode.FamilyNode("root");
  const child1 = new FamilyNode.FamilyNode("child 1");
  const child2 = new FamilyNode.FamilyNode("child 2");
  root.add_child(child1);
  root.add_child(child2);
  root.remove_child(child2);
  expect(root.children).toEqual([child1]);
});

test("Get Parent", () => {
  const root = new FamilyNode.FamilyNode("root");
  const child1 = new FamilyNode.FamilyNode("child 1");
  const child2 = new FamilyNode.FamilyNode("child 2");
  root.add_child(child1);
  root.add_child(child2);
  expect(child1.get_parent()).toEqual(root);
});
