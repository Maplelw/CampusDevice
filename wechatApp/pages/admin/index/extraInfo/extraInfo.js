// pages/mine/details/borrowed/borrowed.js
let setReturned = require('../../../../global/global.js').setReturned;
let getFinishedExtraRecord = require('../../../../global/global.js').getFinishedExtraRecord;
let getUnfinishedExtraRecord = require('../../../../global/global.js').getUnfinishedExtraRecord;
Page({

    /**
     * 页面的初始数据
     */
    data: {
        pageIng: 1, // 页数
        pageDone: 1, // 页数
        flagIng: 0, // 是否最后一页
        flagDone: 0, // 是否最后一页
        choice: "ing",
        ingColor: "#89AFD4",
        doneColor: "#bbbbbb",
        isComment: false,
        extraIng: [],
        extraDone: []
    },
    //顶部状态改变    
    //改变页面显示为 ing
    toIng: function () {
        this.setData({
            choice: "ing",
            ingColor: "#89AFD4",
            doneColor: "#bbbbbb"
        })
    },
    //改变页面显示为 done
    toDone: function () {
        this.setData({
            choice: "done",
            ingColor: "#bbbbbb",
            doneColor: "#89AFD4"
        })
    },

    // 确认归还
    confirmReturn(e) {
        var that = this
        var t = e.currentTarget.dataset.index;
        var ei_no = that.data.extraIng[t].ei_no;
        var d_no = that.data.extraIng[t].d_no;
        wx.showModal({
            title: '提示',
            content: '确认租借？',
            success: (res) => {
                if (res.confirm) {
                    wx.login({
                        success(res) {
                            wx.request({
                                url: setReturned,
                                data: {
                                    code: res.code,
                                    ei_no: ei_no,
                                    d_no: d_no
                                },
                                header: {
                                    'content-type': 'application/x-www-form-urlencoded'
                                },
                                method: 'POST',
                                success: function (res) {
                                    console.log(res.data)
                                    if (res.data.flag === 1) {
                                        that.onShow()
                                    } else {
                                        wx.showToast({
                                            title: res.data.errMsg[0],
                                            icon: "none"
                                        })
                                    }
                                },
                                fail: function (res) {
                                    console.log("请求失败")
                                },
                            })
                        }
                    })
                }
            }
        })
    },

    add() {
        wx.navigateTo({
            url: 'add/add',
        })
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
        var that = this;
        wx.login({
            success: function (res) {
                // ing
                wx.request({
                    url: getUnfinishedExtraRecord,
                    data: {
                        code: res.code,
                        page: that.data.pageIng
                    },
                    header: {
                        'content-type': 'application/x-www-form-urlencoded'
                    },
                    method: 'POST',
                    success: function (res) {
                        console.log("未完成")
                        console.log(res.data)
                        if (res.data.flag === 1) {
                            that.setData({
                                extraIng: res.data.extraIng
                            })
                        } else {
                            wx.showToast({
                                title: res.data.errMsg[0],
                                icon: "none"
                            })
                        }
                    },
                    fail: function (res) {
                        console.log("请求失败")
                    },
                })
            }
        })
        wx.login({
            success(res) {
                // done
                wx.request({
                    url: getFinishedExtraRecord,
                    data: {
                        code: res.code,
                        page: that.data.pageDone
                    },
                    header: {
                        'content-type': 'application/x-www-form-urlencoded'
                    },
                    method: 'POST',
                    success: function (res) {
                        console.log("已经完成")
                        console.log(res.data)
                        if (res.data.flag === 1) {
                            that.setData({
                                extraDone: res.data.extraDone
                            })
                        } else {
                            wx.showToast({
                                title: res.data.errMsg[0],
                                icon: "none"
                            })
                        }
                    },
                    fail: function (res) {
                        console.log("请求失败")
                    },
                })
            }
        })
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
        var that = this
        if (that.data.choice === 'ing') {
            if (that.data.flagIng === 1) { // 到最后一页了
                wx.showToast({
                    title: '已经到最后一个设备',
                    icon: "loading",
                    duration: 500
                })
            } else {
                wx.login({
                    success(res) {
                        wx.request({
                            url: getUnfinishedExtraRecord,
                            data: {
                                page: that.data.pageIng,
                                code: res.code,
                            },
                            method: 'POST',
                            header: {
                                'content-type': 'application/x-www-form-urlencoded'
                            },
                            success: function (res) {
                                console.log(res.data)
                                if (res.data.flag === 0) {
                                    that.setData({
                                        flagIng: 1
                                    })
                                    wx.showToast({
                                        title: '已经到最后一个设备',
                                        icon: "loading",
                                        duration: 500
                                    })
                                } else {
                                    that.setData({
                                        extraIng: that.data.extraIng.concat(res.data.extraIng),
                                        pageDone: that.data.pageDone + 1
                                    })
                                    console.log(that.data.extraIng)
                                }
                            },
                            fail: function (res) {
                                console.log("请求失败")
                            },
                        })
                    }
                })
            }
        } else { //done
            if (that.data.flagDone === 1) { // 到最后一页了
                wx.showToast({
                    title: '已经到最后一个设备',
                    icon: "loading",
                    duration: 500
                })
            } else {
                wx.login({
                    success(res) {
                        wx.request({
                            url: getFinishedExtraRecord,
                            data: {
                                page: that.data.pageDone,
                                code: res.code,
                            },
                            method: 'POST',
                            header: {
                                'content-type': 'application/x-www-form-urlencoded'
                            },
                            success: function (res) {
                                console.log(res.data)
                                if (res.data.flag === 0) {
                                    that.setData({
                                        flagDone: 1
                                    })
                                    wx.showToast({
                                        title: '已经到最后一个设备',
                                        icon: "loading",
                                        duration: 500
                                    })
                                } else {
                                    that.setData({
                                        extraDone: that.data.extraDone.concat(res.data.extraDone),
                                        pageDone: that.data.pageDone + 1
                                    })
                                    console.log(that.data.extraDone)
                                }
                            },
                            fail: function (res) {
                                console.log("请求失败")
                            },
                        })
                    }
                })
            }
        }
    },

    /**
     * 用户点击右上角分享
     */
    onShareAppMessage: function () {

    }
})