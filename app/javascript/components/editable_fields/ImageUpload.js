import React from "react"
import PropTypes from "prop-types"

class ImageUpload extends React.Component {
    constructor(props) {
        super(props);
    }


    _handleImageChange(e) {
        if (this.props.onStartLoadFileHandler != undefined) {
            this.props.onStartLoadFileHandler()
        }
        e.preventDefault();

        let reader = new FileReader();
        let file = e.target.files[0];

        reader.onloadend = () => {
            this.props.onSelectFileHandler(file, reader.result);
        };

        reader.readAsDataURL(file)
    }


    render() {

        return (
            <div>
                <form>
                    <input className="rc-file-input"
                           type="file"
                           onChange={(e)=>this._handleImageChange(e)} />
                </form>
            </div>
        )
    }
}

ImageUpload.propTypes = {
    onStartLoadFileHandler: PropTypes.func,
    onSelectFileHandler: PropTypes.func
};

export default ImageUpload

