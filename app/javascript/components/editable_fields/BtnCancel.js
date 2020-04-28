import React from "react"
import SimpleButton from "./SimpleButton";


function BtnCancel(props) {
    return (
        <SimpleButton onClickHandler={props.onClickHandler} className='btn btn-cancel'>{props.children}</SimpleButton>
    )
}

export default BtnCancel
