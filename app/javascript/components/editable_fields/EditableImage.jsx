import React from "react"
import BaseEditableImage from "./BaseEditableImage"

function EditableImage(props) {
    return (
        <BaseEditableImage view_type="image" image_path={props.image_path} name={props.name}
             name_title={props.name_title} name_hint={props.name_hint} resource_class={props.resource_class}
             cancel_button_text={props.cancel_button_text} submit_button_text={props.submit_button_text}
             url={props.url} read_only={props.read_only}/>
        )
}

export default EditableImage
