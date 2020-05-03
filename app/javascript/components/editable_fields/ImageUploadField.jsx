import React from "react"
import PropTypes from "prop-types"
import RcSquareImage from "./RcSquareImage"


class ImageUploadField extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            spinner: false,
            imagePreviewUrl: this.props.imagePreviewUrl
        };
    }


    _handleImageChange(e) {
        e.preventDefault();
        this.setState({spinner: true});

        let reader = new FileReader();
        let file = e.target.files[0];

        reader.onloadend = () => {
            this.setState({
                spinner: false,
                imagePreviewUrl: reader.result
            });
        };

        reader.readAsDataURL(file)
    }


    render() {

        return (
            <div>
                <RcSquareImage image_path={this.state.imagePreviewUrl} spinner={this.state.spinner}/>
                <input className="rc-file-input"
                       type="file"
                       name={`${this.props.resource_class}[${this.props.name}]`}
                       id={`${this.props.resource_class}_${this.props.name}`}
                       onChange={(e)=>this._handleImageChange(e)} />
            </div>
        )
    }
}

ImageUploadField.propTypes = {
    imagePreviewUrl: PropTypes.string,
    name: PropTypes.string,
    resource_class: PropTypes.string
};

export default ImageUploadField

