let addExtraInfo = require('../../../../../global/global.js').addExtraInfo;
Page({

    /**
     * 页面的初始数据
     */
    data: {

    },
    // 提交表单
    submit(e) {
        var that = this
        var datas = e.detail.value
        console.log(datas.d_no)
        console.log(datas.ei_name)
        console.log(datas.ei_info)
        if (datas.d_no == "" || datas.ei_name == "") {
            wx.showToast({
                title: '请讲信息填写完整',
                icon: "none"
            })
        }
        else {
            wx.showLoading({
                
            })
            wx.login({
                success(res) {
                    wx.request({
                        url: addExtraInfo,
                        method: 'POST',
                        header: {
                            "content-type": "application/x-www-form-urlencoded"
                        },
                        data: {
                            code:res.code,
                            d_no: datas.d_no,
                            ei_name: datas.ei_name,
                            ei_info: datas.ei_info
                        },
                        success(res) {
                            wx.hideLoading()
                            console.log(res.data)
                            if (res.data.flag === 1) {
                                wx.showToast({
                                    title: '添加成功',
                                    duration: 2000,
                                    success() {
                                        wx.navigateBack({})
                                    }
                                })
                            }
                            else {
                                wx.showToast({
                                    title: res.data.errMsg[0],
                                    icon: "none"
                                })
                            }
                        }
                    })
                }
            })
        }
    },

    /**
     * 生命周期函数--监听页面加载
     */
    onLoad: function (options) {

    },

    /**
     * 生命周期函数--监听页面初次渲染完成
     */
    onReady: function () {

    },

    /**
     * 生命周期函数--监听页面显示
     */
    onShow: function () {

    },

    /**
     * 生命周期函数--监听页面隐藏
     */
    onHide: function () {

    },

    /**
     * 生命周期函数--监听页面卸载
     */
    onUnload: function () {

    },

    /**
     * 页面相关事件处理函数--监听用户下拉动作
     */
    onPullDownRefresh: function () {

    },

    /**
     * 页面上拉触底事件的处理函数
     */
    onReachBottom: function () {

    },

    /**
     * 用户点击右上角分享
     */
    onShareAppMessage: function () {

    }
})