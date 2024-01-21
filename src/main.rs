use leptos::*;
mod FamilyTree;

#[component]
fn App() -> impl IntoView {
    view! {
        <p>"Hello World!"</p>
    }
}

fn main() {
    mount_to_body(|| {
        view! { <App/> }
    })
}
